From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 8 Nov 2017 10:49:10 -0800
Subject: [PATCH 0/2] ARM: dts: NSP fixes
In-Reply-To: <20171107222812.17267-1-f.fainelli@gmail.com>
References: <20171107222812.17267-1-f.fainelli@gmail.com>
Message-ID: <0e75e9d6-c2c8-4018-6c18-9e1c9bf19e2e@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/2017 02:28 PM, Florian Fainelli wrote:
> Hi all,
> 
> This patch series contains a couple of fixes:
> 
> - disables AHCI on NSP HR boards since that results in a hard hang
> - fixes PPI interrupts specifiers

Applied to devicetree/fixes.
-- 
Florian
