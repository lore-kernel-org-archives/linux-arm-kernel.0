From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri,  9 Mar 2018 11:07:28 -0800
Subject: [PATCH V2] ARM: dts: BCM5301X: add missing LEDs for Buffalo
 WZR-900DHP
In-Reply-To: <1520422436-9405-1-git-send-email-musashino.open@gmail.com>
References: <1520422436-9405-1-git-send-email-musashino.open@gmail.com>
Message-ID: <20180309190728.31034-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  7 Mar 2018 20:33:56 +0900, musashino.open at gmail.com wrote:
> From: INAGAKI Hiroshi <musashino.open@gmail.com>
> 
> Buffalo WZR-900DHP has 8 LEDs, but there is not LED definitions in the
> dts and cannot configure these LEDs.
> I Added missing LED definitions for WZR-900DHP.
> 
> Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>
> ---

Applied to devicetree/next, thanks!
--
Florian
