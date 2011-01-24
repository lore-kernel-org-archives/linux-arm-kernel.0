From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Jan 2011 15:00:48 +0000
Subject: [PATCH 02/14] ARM: bitops: switch set/clear/change bitops to
	use ldrex/strex
In-Reply-To: <AANLkTimz1YcJ=Me5ZmiwnHcOoa18X-NajX6PQy_g3UH8@mail.gmail.com>
References: <E1Peue4-0003SN-Gk@rmk-PC.arm.linux.org.uk>
	<20110123001636.GA20841@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101222323190.8580@xanadu.home>
	<20110123093526.GA26120@n2100.arm.linux.org.uk>
	<AANLkTi=tpnNXm8w9-VFi72nYvXRQV5-jE7Qn9NNk1wLW@mail.gmail.com>
	<AANLkTinnQLsa4mOV+SLYxeRrwZdc8N36SW9pK6ne+6TQ@mail.gmail.com>
	<20110124102849.GA18459@n2100.arm.linux.org.uk>
	<AANLkTikmwDkdiAPoCx+Oz7qhTbpuOTHeam9gSi=WesSa@mail.gmail.com>
	<20110124141112.GM16202@n2100.arm.linux.org.uk>
	<AANLkTimz1YcJ=Me5ZmiwnHcOoa18X-NajX6PQy_g3UH8@mail.gmail.com>
Message-ID: <20110124150048.GC22949@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 08:24:41PM +0530, Poddar, Sourav wrote:
> nfs filesystem.

Thanks.
