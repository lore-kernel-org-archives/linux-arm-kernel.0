From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 22 Jan 2014 13:25:32 +0200
Subject: [PATCH 1/4] ARM: dts: cm-fx6: rearrange the dts file
In-Reply-To: <20140121204201.GX16215@pengutronix.de>
References: <1390320812-25100-1-git-send-email-grinberg@compulab.co.il>
 <1390320812-25100-2-git-send-email-grinberg@compulab.co.il>
 <20140121204201.GX16215@pengutronix.de>
Message-ID: <52DFAAAC.5040701@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On 01/21/14 22:42, Sascha Hauer wrote:
> Hi Igor,
> 
> On Tue, Jan 21, 2014 at 06:13:29PM +0200, Igor Grinberg wrote:
>> Move the iomuxc definition before the devices definitions
>> (e.g. gpmi, fec).
> 
> The nodes are sorted alphabetically. Please keep them sorted.

Hmmm.. I missed that point... Thanks!

Will fix this up and resend.

-- 
Regards,
Igor.
