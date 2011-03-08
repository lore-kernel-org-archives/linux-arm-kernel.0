From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 08 Mar 2011 18:17:07 +0300
Subject: [PATCH v3 2/7] da850: pruss platform specific additions.
In-Reply-To: <1299592667-21367-3-git-send-email-subhasish@mistralsolutions.com>
References: <1299592667-21367-1-git-send-email-subhasish@mistralsolutions.com>
	<1299592667-21367-3-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <4D764873.2000007@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 08.03.2011 16:57, Subhasish Ghosh wrote:

> This patch adds the platform device and assignes the platform resources
> for the PRUSS mfd driver.

    It also adds the PRUSS clock (which I'd have done in a sperate patch). I 
think I've already said that though...

> Signed-off-by: Subhasish Ghosh<subhasish@mistralsolutions.com>

WBR, Sergei
