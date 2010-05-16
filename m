From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 16 May 2010 18:09:52 +0100
Subject: [patch 3/6] ASoC: Add SOC_DOUBLE_R_SX_TLV control
In-Reply-To: <20100515153130.338630785@mandriva.com>
References: <20100515152958.899927802@mandriva.com>
	<20100515153130.338630785@mandriva.com>
Message-ID: <20100516170853.GA9830@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 15, 2010 at 05:30:01PM +0200, apatard at mandriva.com wrote:
> This patch is adding a new control which has the following capabilities:
> - tlv
> - variable data size (for instance, 7 ou 8 bit)
> - double mixer
> - data range centered around 0
> 
> Signed-off-by: Arnaud Patard <apatard@mandriva.com>

I've applied this one.  Please remember to CC both myself and Liam on
ASoc patches.
