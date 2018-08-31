From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Fri, 31 Aug 2018 10:11:24 +0200
Subject: [PATCH v6 11/11] arm64: annotate user pointers casts detected by
 sparse
In-Reply-To: <5d54526e5ff2e5ad63d0dfdd9ab17cf359afa4f2.1535629099.git.andreyknvl@google.com>
References: <cover.1535629099.git.andreyknvl@google.com>
 <5d54526e5ff2e5ad63d0dfdd9ab17cf359afa4f2.1535629099.git.andreyknvl@google.com>
Message-ID: <20180831081123.6mo62xnk54pvlxmc@ltop.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2018 at 01:41:16PM +0200, Andrey Konovalov wrote:
> This patch adds __force annotations for __user pointers casts detected by
> sparse with the -Wcast-from-as flag enabled (added in [1]).
> 
> [1] https://github.com/lucvoo/sparse-dev/commit/5f960cb10f56ec2017c128ef9d16060e0145f292

Hi,

It would be nice to have some explanation for why these added __force
are useful.

-- Luc Van Oostenryck
