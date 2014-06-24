From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Jun 2014 17:35:47 +0100
Subject: [PATCH v14 04/10] imx-drm: use defines for clock polarity settings
In-Reply-To: <53A9A66F.20401@eukrea.com>
References: <1402913484-25910-1-git-send-email-denis@eukrea.com>
 <1402913484-25910-4-git-send-email-denis@eukrea.com>
 <20140624151323.GU32514@n2100.arm.linux.org.uk> <53A9A66F.20401@eukrea.com>
Message-ID: <20140624163547.GZ32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 06:25:19PM +0200, Denis Carikli wrote:
> On 06/24/2014 05:13 PM, Russell King - ARM Linux wrote:
> [...]
>> If you'd like to send me better commit messages for
>> these patches, I'll add them to what I already have:
>
>> 	imx-drm: use defines for clock polarity settings
> The comment of the clk_pol field of the ipu_di_signal_cfg struct was  
> inverted.
> Instead of merely inverting the comment, the values of clk_pol were defined.

s/inverting/fixing/

>
>> 	imx-drm: add RGB666 support for parallel display.
> This permits to drive parallel displays that expect the RGB666 color format.

This allows imx-drm to drive ...

>>
>> It may also be worth describing the RGB666 format in the commit message
>> for:
>>
>> 	v4l2: add new V4L2_PIX_FMT_RGB666 pixel format.
> The RGB666 color format encodes 6 bits for each color(red, green and  
> blue), linearly.
> It looks like this in memory:
> 0                17
> RRRRRRGGGGGGBBBBBB

Thanks! I've tweaked them very slightly as detailed above so they read a
bit better.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
