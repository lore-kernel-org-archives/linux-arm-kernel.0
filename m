From: bp@alien8.de (Borislav Petkov)
Date: Thu, 11 Feb 2016 12:27:58 +0100
Subject: [PATCHv10 2/4] ARM: dts: Add Altera L2 Cache and OCRAM EDAC
 entries
In-Reply-To: <1455132384-17108-2-git-send-email-tthayer@opensource.altera.com>
References: <1455132384-17108-1-git-send-email-tthayer@opensource.altera.com>
 <1455132384-17108-2-git-send-email-tthayer@opensource.altera.com>
Message-ID: <20160211112758.GA5565@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 01:26:22PM -0600, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> Adding the device tree entries and bindings needed to support
> the Altera L2 cache and On-Chip RAM EDAC. This patch relies upon
> an earlier patch to declare and setup On-chip RAM properly.
> http://www.spinics.net/lists/devicetree/msg51117.html

For the future, please use git commit IDs and not some, probably
unstable URLs:

  8b907c8b62ac ("arm: dts: socfpga: Add OCRAM node")

I've fixed it now while applying.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
