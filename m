From: geoff@infradead.org (Geoff Levand)
Date: Tue, 22 Nov 2016 10:57:10 -0800
Subject: [PATCH 2/2] arm64: Pass RAM boundary and enable-dcache flag to
 purgatory
In-Reply-To: <b1b9e70db9d08364040436154cf0cf2f4600da49.1479788404.git.panand@redhat.com>
References: <cover.1479788404.git.panand@redhat.com>
 <b1b9e70db9d08364040436154cf0cf2f4600da49.1479788404.git.panand@redhat.com>
Message-ID: <53ee2a62-7822-5457-e59f-e65e64a57019@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pratyush,

On 11/21/2016 08:32 PM, Pratyush Anand wrote:
> When "enable-dcache" is passed to the kexec() command line, kexec-tools
> passes this information to purgatory, which in turn enables cache during
> sha-256 verification.

What's the point of this enable-dcache option?  Why not just
always enable the cache if we can?

-Geoff
