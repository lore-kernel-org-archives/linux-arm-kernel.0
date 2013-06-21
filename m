From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 21 Jun 2013 11:48:36 -0700
Subject: [PATCH v2 3/3] ARM: KVM: clear exclusive monitor on all
 exception returns
In-Reply-To: <51C45B35.7030508@cogentembedded.com>
References: <1371816528-25078-1-git-send-email-marc.zyngier@arm.com>
 <1371816528-25078-4-git-send-email-marc.zyngier@arm.com>
 <51C45B35.7030508@cogentembedded.com>
Message-ID: <20130621184836.GB2816@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 05:55:01PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 21-06-2013 16:08, Marc Zyngier wrote:
> 
> >Make sure we clear the exclusive movitor on all exception returns,
> 
>    Only "monitor". Perhaps a committer could fix...
> 
fixed,
-Christoffer
