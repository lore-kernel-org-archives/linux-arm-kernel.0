From: brian@walsh.ws (Brian Walsh)
Date: Thu, 24 Sep 2009 12:57:29 -0400
Subject: ixp4xx dmabounce
In-Reply-To: <m3ljk4xp3t.fsf@intrepid.localdomain>
References: <a104b22c0909171402x10c06d41oa5c78065a65836e1@mail.gmail.com>
	<19129.24807.954274.688709@pilspetsen.it.uu.se>
	<m33a6dk9li.fsf@intrepid.localdomain>
	<a104b22c0909240902g31da6983w26be4526cbdfc16c@mail.gmail.com>
	<m3ljk4xp3t.fsf@intrepid.localdomain>
Message-ID: <a104b22c0909240957o3a6aa27kf855c43cb3bbc76d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 24, 2009 at 12:51 PM, Krzysztof Halasa <khc@pm.waw.pl> wrote:
> Brian Walsh <brian@walsh.ws> writes:
>
>> I tried Krzysztof's patch and it had no noticeable affect. ?I am still getting
>> about 6.3 Mbps IP data throughput when only using the ohci controller and
>> about 3.6 Mbps when the device is attached to the ehci controller. ?This
>> device works fine when running the same testing attached to an x86
>> configured machine and gets about 18 Mbps IP data throughput.
>
> I assume you've enabled CONFIG_ZONE_DMA_ALL_KERNEL :-)
>
> Either the bouncing isn't the problem in this case, or the allocations
> are GFP_USER.
> --
> Krzysztof Halasa
>

Ha.  Yes, I did enable that option.

I am doing my testing just by using wget to pull a file over the connection.
