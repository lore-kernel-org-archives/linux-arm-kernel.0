From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 12 Feb 2018 12:22:21 -0800
Subject: [PATCH] hwrng: bcm2835: Handle deferred clock properly
In-Reply-To: <1518466296-30161-1-git-send-email-stefan.wahren@i2se.com>
References: <1518466296-30161-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <d3f5b375-d2e8-2e7c-526d-aa5d49751ed4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/2018 12:11 PM, Stefan Wahren wrote:
> In case the probe of the clock is deferred, we would assume it is
> optional. This is wrong, so defer the probe of this driver until
> the clock is available.
> 
> Fixes: 791af4f4907a ("hwrng: bcm2835 - Manage an optional clock")
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks Stephan!
-- 
Florian
