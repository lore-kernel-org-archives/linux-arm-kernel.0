From: dianders@google.com (Doug Anderson)
Date: Tue, 24 Jun 2014 15:57:59 -0700
Subject: [PATCH 0/3] MCPM: clarify boot CPU situation wrt CCI
In-Reply-To: <7hd2dymiaw.fsf@paris.lan>
References: <1403583071-5650-1-git-send-email-nicolas.pitre@linaro.org>
 <7hd2dymiaw.fsf@paris.lan>
Message-ID: <CAD=FV=WHU0TDkjXVCCw6odBFSF7uvv3joCP+oW4cBS_tsSgF+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin,

On Tue, Jun 24, 2014 at 8:35 AM, Kevin Hilman <khilman@linaro.org> wrote:
> - Leave mau_epll enabled
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/262259.html

Can you drop your mau_epll one and instead pick just
<https://patchwork.kernel.org/patch/4333581/>?

I noticed that Tushar has only been pushing for that patch to be
applied and I'm going to guess that the "leave mau_epll enabled" isn't
needed.  I just tested myself and confirmed that things are happy.
