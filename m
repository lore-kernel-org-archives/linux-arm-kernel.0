From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 16 Jul 2012 21:40:06 +0530
Subject: [GIT PULL] DaVinci DT support for v3.6
In-Reply-To: <201207131644.02961.arnd@arndb.de>
References: <50003C21.9080500@ti.com> <201207131644.02961.arnd@arndb.de>
Message-ID: <50043CDE.1080208@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 7/13/2012 10:14 PM, Arnd Bergmann wrote:
> On Friday 13 July 2012, Sekhar Nori wrote:
>> Hi Arnd, Olof,
>>
>> Can you please pull the following patch adding DT support for DaVinci 
>> for v3.6?
>>
>> Sorry for the late request, I was waiting for an ack from either Grant 
>> or Rob but looks like both are busy. Grant has reviewed earlier versions
>> of the patch.
>>
>> This pull request depends on DaVinci SoC updates pulled earlier.
>>
> 
> Pulled, thanks!
> 
> I'm a bit surprised to see DT support series for davinci when the platform
> doesn't support DT booting and the series doesn't add it, but I suppose
> you're still working on other parts.

Yes, the other parts are still being worked on.

> 
>>From what I can tell, this is the second out of seven patches from Heiko,
> where the first one was part of the initial set. Are you planning to submit
> the others for 3.6 still, or is this for after the merge window?

Patches 4-6 of his series are driver patches. While I am
reviewing/testing and acking those patches, I will still be depending on
the driver maintainers to merge those through their trees. So after I am
done reviewing and testing, I am asking Heiko to post those as
independent patches copying the driver maintainers.

Patch 3 in his series adds aemif DT support. I want to take this along
with movement of AEMIF to drivers. There is ongoing work in OMAP world
in moving a similar peripheral (GPMC) to drivers/. I believe
drivers/memory is being looked at as a possible place. This movement
will not happen for this merge window.

The last patch in the series adds support for the board Heiko is working
on. I have not yet had a look at this patch. I will look into this only
for the next merge window.

Thanks,
Sekhar
