From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 Jan 2015 14:13:52 -0800
Subject: [GIT PULL] Broadcom MAINTAINERS file updates for 3.20 (v3)
In-Reply-To: <1422564023-28977-1-git-send-email-f.fainelli@gmail.com>
References: <1422564023-28977-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <CAOesGMinXsH41g6vFw5zX5CwxfBK09gGanOe6EyGrjgxwVN_zA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 29, 2015 at 12:40 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
>
>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
>
> are available in the git repository at:
>
>   http://github.com/broadcom/stblinux tags/arm-soc/for-3.20/maintainer
>
> for you to fetch changes up to 5e2aed2746a02f677cc07679407360ab80b4106a:
>
>   MAINTAINERS: add a git entry for BMIPS-based BCM7xxx SoCs (2015-01-29 12:31:30 -0800)
>
> Arnd, Olof, please drop the previous pull request and use this one instead, thanks!

Unfortuantely, we don't just swap out merges for you when you have a
better branch to send us. It's a lot of work to do so.

If you need to fix something up, please send either a patch that we
apply on the same next/* branch, or a pull request of an incremental
branch (i.e. based on the previously merged branch head but with the
patch applied on top).


-Olof
