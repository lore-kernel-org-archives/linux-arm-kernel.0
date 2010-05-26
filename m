From: saeed.bishara@gmail.com (saeed bishara)
Date: Wed, 26 May 2010 08:15:25 +0300
Subject: [patch 4/5] orion/kirkwood: Add i2s support
In-Reply-To: <alpine.LFD.2.00.1005252025210.24526@xanadu.home>
References: <20100525122236.841941526@mandriva.com>
	<20100525122341.443140710@mandriva.com>
	<alpine.LFD.2.00.1005252025210.24526@xanadu.home>
Message-ID: <AANLkTim0m_zJ0J_9FMmXgKfS8ovQZpV-qxtHyOS2D3ZL@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 26, 2010 at 3:31 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Tue, 25 May 2010, apatard at mandriva.com wrote:
>
>> This patch enables support for the i2s controller available on orion/kirkwood platforms
>>
>> Signed-off-by: Arnaud Patard <apatard@mandriva.com>
>
> The actual Orion processor family has no I2S/audio support. ?It would be
> better if all the audio related stuff was renamed to "kirkwood" and
> "KIRKWOOD_*" instead.
This i2s was first included in orion90L (6183).

saeed
