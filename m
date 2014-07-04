From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 4 Jul 2014 11:02:57 +0300
Subject: [PATCH 0/4] SiI9022 HDMI encoder for AM4xxx boards
In-Reply-To: <87k37u7bp5.fsf@lebrac.rtp-net.org>
References: <1404394800-18138-1-git-send-email-tomi.valkeinen@ti.com>
 <87k37u7bp5.fsf@lebrac.rtp-net.org>
Message-ID: <53B65FB1.5020901@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/07/14 17:34, Arnaud Patard wrote:
> Tomi Valkeinen <tomi.valkeinen@ti.com> writes:
> 
>> Hi,
> 
> Hi,
> 
>>
>> This series adds a driver for SiI9022 HDMI encoder, which is used on AM437x GP
>> and AM43x EPOS boards.
>>
>> The series is based on the OMAPDSS HDMI infoframe series sent earlier, as the
>> SiI9022 driver uses the new infoframe support.
> 
> Is there any small possibility to not make it an omap specific driver?
> There are other boards with sii9022 out there. imx5x dev boards could
> receive a daughter board with this chip (both sold by Freescale) and
> efikamx platform has it too. I think that some old msm platforms has it
> too.
> I've not compared the code of the drivers and don't know how the sii9022
> works but would be annoying to have 2 or more drivers for the same piece
> of HW. imho, it would be nice if it could be avoided.

No, not at the moment. There is no framework to create generic drivers
for display components.

There has been work towards that (google for "Common Display
Framework"), but that is far from finished.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140704/2563c878/attachment.sig>
