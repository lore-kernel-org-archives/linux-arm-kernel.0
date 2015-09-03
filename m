From: will.deacon@arm.com (Will Deacon)
Date: Thu, 3 Sep 2015 11:13:28 +0100
Subject: [PATCH v5 1/4] arm64, numa: adding numa support for arm64
 platforms.
In-Reply-To: <CAFpQJXXiU3LcUWvjP8r4pHUysYe7X4DJBvjhXzf+p4qaJdBVWA@mail.gmail.com>
References: <1439570374-4079-1-git-send-email-gkulkarni@caviumnetworks.com>
 <1439570374-4079-2-git-send-email-gkulkarni@caviumnetworks.com>
 <CAFpQJXXiU3LcUWvjP8r4pHUysYe7X4DJBvjhXzf+p4qaJdBVWA@mail.gmail.com>
Message-ID: <20150903101328.GB877@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 03, 2015 at 10:52:02AM +0100, Ganapatrao Kulkarni wrote:
> On Fri, Aug 14, 2015 at 10:09 PM, Ganapatrao Kulkarni
> <gkulkarni@caviumnetworks.com> wrote:
> > Adding numa support for arm64 based platforms.
> > This patch adds by default the dummy numa node and
> > maps all memory and cpus to node 0.
> > using this patch, numa can be simulated on single node arm64 platforms.
> >
> > Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>

[trimmed ~850 lines of context]

> can you please review this patch.

It's the middle of the merge window, please be patient.

Will
