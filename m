From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 23 Jan 2014 17:16:46 -0700
Subject: [PATCH] ARM: multi_v7: copy most options from tegra_defconfig
In-Reply-To: <CAOesGMj-nvMZhoX4fCe-mf0pBS27=EsS0o2bX7MgmZzjWhYVzQ@mail.gmail.com>
References: <1387569848-16563-1-git-send-email-swarren@wwwdotorg.org>	<CAOesGMh4PkdTh8EP1WS9-_5cVe1NWuNQPbkskk7hJhtbBEPWBg@mail.gmail.com>	<52B4A7E9.9090900@wwwdotorg.org>	<20131222200549.GA11575@quad.lixom.net>
 <CAOesGMj-nvMZhoX4fCe-mf0pBS27=EsS0o2bX7MgmZzjWhYVzQ@mail.gmail.com>
Message-ID: <52E1B0EE.6080808@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/23/2013 10:37 AM, Olof Johansson wrote:
> On Sun, Dec 22, 2013 at 12:05 PM, Olof Johansson <olof@lixom.net> wrote:
>> On Fri, Dec 20, 2013 at 01:26:17PM -0700, Stephen Warren wrote:
>>> On 12/20/2013 01:16 PM, Olof Johansson wrote:
>>>> On Fri, Dec 20, 2013 at 12:04 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>>> multi_v7_defconfig was missing a large number of options that were in
>>>> tegra_defconfig. This patch adds them. The changes fall into the
>>>> following categories:
...
>> Ok, fair enough. Applied.
> 
> Actually, this one ended up getting messy. We've had
> multi_v7_defconfig updates in several branches so this doesn't apply
> cleanly anywhere.
> 
> I'll apply it on top of for-next where the various branches are
> merged. It means we'll have to merge it late. Not a big deal, but
> please help me remember it in case it for some reason gets lost in the
> shuffle.

I guess this is the correct time to remind you about this? That said,
the patch is in linux-next, so perhaps that counts as not having been
lost:-)
