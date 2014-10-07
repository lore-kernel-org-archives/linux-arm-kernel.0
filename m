From: geoff@infradead.org (Geoff Levand)
Date: Tue, 07 Oct 2014 11:42:00 -0700
Subject: [PATCH 6/7] arm64/kexec: Add core kexec support
In-Reply-To: <20141007134450.GE27464@redhat.com>
References: <cover.1411604443.git.geoff@infradead.org>
 <471af24b7de659a30a5941e793634bffec380cb9.1411604443.git.geoff@infradead.org>
 <20140930181840.GA24153@redhat.com> <1412106877.6630.45.camel@smoke>
 <20141001145602.GB13689@redhat.com> <1412361303.32313.24.camel@smoke>
 <20141007134450.GE27464@redhat.com>
Message-ID: <1412707320.32313.100.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vivek,

On Tue, 2014-10-07 at 09:44 -0400, Vivek Goyal wrote:
> So as Mark and I discussed need of purgatory code in other mails, are you
> plannign to enable purgatory on arm64.

Adding purgatory code to arm64 is low priority, and I currently
have no plan to do that.  Users are asking for kdump, and proper
UEFI support, so that is what I will work towards.

-Geoff
