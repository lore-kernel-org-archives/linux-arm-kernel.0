From: jarkko.nikula@bitmer.com (Jarkko Nikula)
Date: Fri, 10 Aug 2012 16:15:26 +0300
Subject: [PATCH 00/11] ARM/ASoC: OMAP McBSP device tree support
In-Reply-To: <20120808112132.GN16861@opensource.wolfsonmicro.com>
References: <1344417101-5015-1-git-send-email-peter.ujfalusi@ti.com>
 <20120808112132.GN16861@opensource.wolfsonmicro.com>
Message-ID: <5025096E.8030300@bitmer.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/2012 02:21 PM, Mark Brown wrote:
> On Wed, Aug 08, 2012 at 12:11:30PM +0300, Peter Ujfalusi wrote:
> 
>> The series changes McBSP related files mostly. It would be great if the whole
>> series could go via audio tree (if the patches are OK and it is fine by Tony).
> 
> I'm OK with all the patches, if Tony's happy with me applying them then
> I'll put them in a separate branch so they can easily be merged into the
> OMAP trees (or similarly if it's applied in an OMAP tree having a branch
> I can merge if needed would be good).

I suppose we could apply 1/11, 3-6/11 and 9-10 right away (2/11 perhaps
should go near 11/11?) and apply 7-8/11 (sidetone patches that increase
consumption) later?

My ack to patches 1, 3-6 and 9-10:

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
