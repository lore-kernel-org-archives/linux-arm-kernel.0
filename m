From: jcm@redhat.com (Jon Masters)
Date: Sun, 7 Jan 2018 19:15:28 -0500
Subject: [PATCH v2 07/11] arm64: Add skeleton to harden the branch
 predictor against aliasing attacks
In-Reply-To: <1515157961-20963-8-git-send-email-will.deacon@arm.com>
References: <1515157961-20963-1-git-send-email-will.deacon@arm.com>
 <1515157961-20963-8-git-send-email-will.deacon@arm.com>
Message-ID: <6d28c672-5083-28cf-b5a7-dcc791ca3025@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05/2018 08:12 AM, Will Deacon wrote:

> Aliasing attacks against CPU branch predictors can allow an attacker to
> redirect speculative control flow on some CPUs and potentially divulge
> information from one context to another.
> 
> This patch adds initial skeleton code behind a new Kconfig option to
> enable implementation-specific mitigations against these attacks for
> CPUs that are affected.

Thanks to Qualcomm for the (typically prompt and immediate) followup. As
a reminder to the other usual server suspects (all of whom we've spoken
with about mitigations for this so we know there things coming), I'm
expecting to see your patches for this hit the list within the next 48
hours. You know who you are, and I'll be doing the rounds over the next
24 hours to check your status as to when you'll be posting these.

Thanks,

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
