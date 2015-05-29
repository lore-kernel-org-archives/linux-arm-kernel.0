From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 28 May 2015 21:01:23 -0700
Subject: [PATCH 8/9] bus: brcmstb_gisb: Honor the "big-endian" and
 "native-endian" DT properties
In-Reply-To: <1416962994-27095-9-git-send-email-cernekee@gmail.com>
References: <1416962994-27095-1-git-send-email-cernekee@gmail.com>
 <1416962994-27095-9-git-send-email-cernekee@gmail.com>
Message-ID: <5567E493.80800@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 11/25/14 16:49, Kevin Cernekee a ?crit :
> On chips strapped for BE, we'll need to use ioread32be/iowrite32be instead of
> ioread32/iowrite32.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

Applied to soc/next, thanks!
-- 
Florian
