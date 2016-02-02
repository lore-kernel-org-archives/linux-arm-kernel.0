From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 02 Feb 2016 10:46:59 -0800
Subject: [PATCH] ARM: BCM63xx: Remove unused pmb_dn variable
In-Reply-To: <1454286768-20736-1-git-send-email-f.fainelli@gmail.com>
References: <1454286768-20736-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <56B0F9A3.7050306@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/01/16 16:32, Florian Fainelli wrote:
> Introduced in commit 3f2a43c98d72b ("ARM: BCM63xx: Add secondary CPU PMB
> initialization sequence"), but not used by the code.
> 
> Reported-by: David Binderman <dcb314@hotmail.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to soc/next.
-- 
Florian
