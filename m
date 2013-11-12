From: olof@lixom.net (Olof Johansson)
Date: Tue, 12 Nov 2013 12:38:23 -0800
Subject: [PATCH v10 0/7] ARM: support for Trusted Foundations secure
 monitor
In-Reply-To: <52828EF5.6090909@wwwdotorg.org>
References: <1383819106-1400-1-git-send-email-acourbot@nvidia.com>
 <52828EF5.6090909@wwwdotorg.org>
Message-ID: <CAOesGMhatp9ZQr=eTCtQ_9a_E9LXKdTCzJd+P7Sy9Ut9wtvnsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 12, 2013 at 12:26 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 11/07/2013 03:11 AM, Alexandre Courbot wrote:
>> Just a set of small fixes to address the concerns expressed on v9 with the
>> non-prefixed version DT properties. I hope there won't be a need for an
>> eleventh (!) version. :P
>
> BTW, this version looks fine to me. On IRC, Olof said it looked OK to
> him. I'm just waiting to hear back from Olof/Russell whether I should
> merge this through the Tegra tree, or whether the first 1-3 patches
> should go through Russell's tree.

I pinged Russell, and he brought up the fact that there were earlier
requests to move it to drivers/firmware. It would make sense to try to
get that done before merging, especially if you anticipate someone
using TF on 64-bit platforms.


-Olof
