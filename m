From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 8 Feb 2016 22:56:05 +0800
Subject: [PATCH 07/11] ARM: dts: sunxi: Add dtsi file for AXP809 PMIC
In-Reply-To: <20160208145347.GD7265@sirena.org.uk>
References: <1454408864-24112-1-git-send-email-wens@csie.org>
 <1454408864-24112-8-git-send-email-wens@csie.org>
 <20160202121733.GO4455@sirena.org.uk>
 <CAGb2v657zYT30KbuK0fyVOmhv0kzJjj9gTsTFRaS4i3d6YhiHQ@mail.gmail.com>
 <20160208145347.GD7265@sirena.org.uk>
Message-ID: <CAGb2v64ySLAVbPf_XaZnzm5T=SmQLip4iO2p4cGXg=C0=51eqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 8, 2016 at 10:53 PM, Mark Brown <broonie@kernel.org> wrote:
> On Sat, Feb 06, 2016 at 08:42:24PM +0800, Chen-Yu Tsai wrote:
>
>> Mark, may I assume you are OK with this DTS include listing
>> the regulators, even if their sections are empty?
>
> If it has no content why have it?

I'd like the regulator core to disable any unused ones. The core
considers regulators that don't have nodes as not having constraints,
and won't touch them.

Any other ways to do this? Or am I going about this the wrong way?

Thanks
ChenYu
