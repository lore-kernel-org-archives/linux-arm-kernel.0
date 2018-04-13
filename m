From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 13 Apr 2018 14:39:24 -0700
Subject: [PATCH 1/2] dt-binding: rng: Add interrupt property for BCM2835
In-Reply-To: <1511010253-5006-2-git-send-email-stefan.wahren@i2se.com>
References: <1511010253-5006-1-git-send-email-stefan.wahren@i2se.com>
 <1511010253-5006-2-git-send-email-stefan.wahren@i2se.com>
Message-ID: <b54e629b-e142-fdae-b166-124b991f8882@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2017 05:04 AM, Stefan Wahren wrote:
> As Sylvain Garrigues pointed out the BCM2835 RNG block has an
> interrupt. Also in preparation for Florian's upcoming patch series
> add this property to the binding. While we are at it fix the
> indenting of the example.
> 
> Link: https://github.com/raspberrypi/linux/issues/2195
> CC: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Applied to devicetree/next, thanks!
-- 
Florian
