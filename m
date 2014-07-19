From: rostedt@goodmis.org (Steven Rostedt)
Date: Sat, 19 Jul 2014 17:56:55 -0400
Subject: [PATCH 2/4] ARM: add IPI tracepoints
In-Reply-To: <CAKv+Gu-RZ4s+33LVOK3eTrvb3ig0YXmNwT0-3GS2-WuvThyXTg@mail.gmail.com>
References: <1405660735-13408-1-git-send-email-nicolas.pitre@linaro.org>
 <1405660735-13408-3-git-send-email-nicolas.pitre@linaro.org>
 <20140718160418.54d11f6a@gandalf.local.home>
 <alpine.LFD.2.11.1407181652080.3647@knanqh.ubzr>
 <20140718172221.6dbe83e4@gandalf.local.home>
 <CAKv+Gu_71vJFf3aUZso1X7m7fULUMhxj+MZVYq+LGNRLJvGyAA@mail.gmail.com>
 <20140719162810.02285fc8@gandalf.local.home>
 <CAKv+Gu-RZ4s+33LVOK3eTrvb3ig0YXmNwT0-3GS2-WuvThyXTg@mail.gmail.com>
Message-ID: <20140719175655.249601bf@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 19 Jul 2014 22:50:16 +0200
Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

 
> OK, so if the general case has been fixed, perhaps we should ask Paul
> to drop my patch?
> 

No, for a few reasons. One, this patch still needs to get in to fix the
problem for RCU. Two, RCU basically open codes the creation of the
string, thus this wont solve it for RCU.

-- Steve
