From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 20 Jul 2018 02:28:26 -0700
Subject: [PATCH] arm64: fix for restoring console loglevel after handling
 traps
In-Reply-To: <1531993734-1463-1-git-send-email-hari.vyas@broadcom.com>
References: <1531993734-1463-1-git-send-email-hari.vyas@broadcom.com>
Message-ID: <6dd45501-037d-3b18-13e2-77ee151584da@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/19/2018 02:48 AM, Hari Vyas wrote:
> changes in v1:
> 	Separate functions for changing, retrieving, storing and restoring
> 	console loglevel messages.
> 	Restoring console loglevel message is done from arm64 trap handling
> 	code but can be extended on need basis by other user.
> 	Restoring is actually required in die() function only and other places
> 	kernel will panic but added considering code completion

Hari, there is no need for a cover letter for single patch submissions,
if you want to put a changelog, you can put it after the --- below your
Signed-off-by tag, thank you.
-- 
Florian
