From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 22 Mar 2017 09:49:24 -0700
Subject: [PATCH V2 1/2] ARM: dts: BCM5301X: Specify serial console params
 in dtsi files
In-Reply-To: <20170315170328.13879-1-zajec5@gmail.com>
References: <20170314075830.2247-1-zajec5@gmail.com>
 <20170315170328.13879-1-zajec5@gmail.com>
Message-ID: <c900cc9c-3650-f6f0-3650-01f05f680fcd@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/15/2017 10:03 AM, Rafa? Mi?ecki wrote:
> From: Rafa? Mi?ecki <rafal@milecki.pl>
> 
> So far every Northstar device we have seen was using the same serial
> console params (115200n8). It probably make the most sense to put it in
> some proper dtsi files instead of repeating over and over for every
> single device. As different boards may use different bootloaders it
> seems the safest idea is to use board specific dtsi files.
> 
> Just in case some vendor decides to use different UART (parameters) this
> can be always easily overwritten.
> 
> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>

Applied, thanks!
-- 
Florian
