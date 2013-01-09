From: olof@lixom.net (Olof Johansson)
Date: Tue, 8 Jan 2013 19:23:17 -0800
Subject: [GIT PULL] ARM: arm-soc fixes for 3.8-rc
In-Reply-To: <CAOesGMgdV1dD5stpCiWVO8kL+E9U4+_3Zc7gUQ0YEiah4t1LbQ@mail.gmail.com>
References: <20130108184920.GA1258@quad.lixom.net>
 <CA+55aFxxv2h8TAxvwprdQEpaz4Ww5ime+t8rmpjnjv2t-mWYaQ@mail.gmail.com>
 <CAOesGMgdV1dD5stpCiWVO8kL+E9U4+_3Zc7gUQ0YEiah4t1LbQ@mail.gmail.com>
Message-ID: <CAOesGMiEPc1wsv+_K-fPny7U128dcpv1c8cQHsovVoE_9XWiYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 8, 2013 at 7:13 PM, Olof Johansson <olof@lixom.net> wrote:

> Or maybe a better solution is to make git request-pull throw an error
> if there is a local signed tag for the request, but none is found on
> the server (or has different contents). I'll take a look at that.

A-HA! Git does that as of 1.7.11.2 / 1.7.12, my version was just a
little too old.


-Olof
