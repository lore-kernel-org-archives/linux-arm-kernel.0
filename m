From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 21 Jun 2013 17:55:01 +0400
Subject: [PATCH v2 3/3] ARM: KVM: clear exclusive monitor on all exception
 returns
In-Reply-To: <1371816528-25078-4-git-send-email-marc.zyngier@arm.com>
References: <1371816528-25078-1-git-send-email-marc.zyngier@arm.com>
 <1371816528-25078-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <51C45B35.7030508@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 21-06-2013 16:08, Marc Zyngier wrote:

> Make sure we clear the exclusive movitor on all exception returns,

    Only "monitor". Perhaps a committer could fix...

> which otherwise could lead to lock corruptions.

> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

WBR, Sergei
