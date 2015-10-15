From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 15 Oct 2015 13:27:17 +0300
Subject: [PATCH] ARM: shmobile: porter: add HS-USB DT support
In-Reply-To: <20151015001818.GA25019@verge.net.au>
References: <1674850.BZpGW9kEud@wasted.cogentembedded.com>
 <80272771.MSjafmr6yE@wasted.cogentembedded.com>
 <20151015001818.GA25019@verge.net.au>
Message-ID: <561F7F85.1090306@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 10/15/2015 3:18 AM, Simon Horman wrote:

>> Enable HS-USB device  for the Porter board, defining the GPIO that the
>> driver should check  when probing (which is the ID output from MAX3355
>> OTG chip).
>>
>> Note that there  will be pinctrl-related error messages if both internal
>> PCI  and  HS-USB drivers are enabled but they should be just ignored.
>>
>> This patch is  analogous  to the commit 6f4f7156e0e6 (ARM: shmobile:
>> henninger: enable HS-USB) as there  are no differences between the
>> boards in this respect.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> Thanks Sergei,
>
> I have queued this up for v4.5.
>
> I took the liberty of tweaking the changelog to address a complaint made
> by Mr. Check Patch.

    Which means I forgot to run it again. Sorry about that. :-<

> ERROR: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'commit 6f4f7156e0e6 ("ARM: shmobile: henninger: enable HS-USB")'

    Keep forgetting about the now enforced quotes...

MBR, Sergei
