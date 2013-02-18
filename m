From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 18 Feb 2013 13:33:18 +0000
Subject: [PATCH RFC 1/7] platform: add a device node
In-Reply-To: <20130210093708.GL17852@n2100.arm.linux.org.uk>
References: <1360442671-15216-1-git-send-email-javier.martinez@collabora.co.uk>
 <1360442671-15216-2-git-send-email-javier.martinez@collabora.co.uk>
 <20130210010246.GA1455@kroah.com> <5116FCA1.40703@collabora.co.uk>
 <20130210093708.GL17852@n2100.arm.linux.org.uk>
Message-ID: <CACxGe6vEjm0pe_gRNCLrGvf2_eJ-NGP+=Jwm-phm4RWBV_szUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 10, 2013 at 9:37 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Feb 10, 2013 at 02:49:21AM +0100, Javier Martinez Canillas wrote:
>> I knew this would be controversial and that's why I didn't mean it to be a patch
>> but a RFC :)
>>
>> The problem basically is that you have to associate the platform device with its
>> corresponding DT device node because it can be used in the driver probe function.
>
> When DT is being used, doesn't DT create the platform devices for you,
> with the device node already set correctly?
>
> Manually creating platform devices and adding DT nodes to it sounds like
> the wrong thing to be doing.

Right; I'd expect your platform device creation to go through the
of_platform_populate() route. What is your use-case?

g.



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
