From: drjones@redhat.com (Andrew Jones)
Date: Wed, 2 Dec 2015 16:34:56 -0600
Subject: [PATCH v2 10/21] arm64: KVM: Add patchable function selector
In-Reply-To: <1448650215-15218-11-git-send-email-marc.zyngier@arm.com>
References: <1448650215-15218-1-git-send-email-marc.zyngier@arm.com>
 <1448650215-15218-11-git-send-email-marc.zyngier@arm.com>
Message-ID: <20151202223456.GK3233@hawk.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 27, 2015 at 06:50:04PM +0000, Marc Zyngier wrote:
> KVM so far relies on code patching, and is likely to use it more
> in the future. The main issue is that our alternative system works
> at the instruction level, while we'd like to have alternatives at
> the function level.

How about setting static-keys at hyp init time?

Thanks,
drew
