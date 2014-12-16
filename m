From: richardcochran@gmail.com (Richard Cochran)
Date: Tue, 16 Dec 2014 16:30:48 +0100
Subject: [PATCH v4 0/6] Touchscreen performance related fixes
In-Reply-To: <CABH3fy8S1Hb9LK=ZceWgJsNvLbq8pwu00Tcj_0vE4j6QzcO+kg@mail.gmail.com>
References: <1415941651-28962-1-git-send-email-vigneshr@ti.com>
 <20141124115116.GA14997@linutronix.de> <547C3A95.30605@ti.com>
 <547C3C19.5090501@linutronix.de> <547C42FF.5010700@ti.com>
 <CAH=tA9FO5MCzE274thc-NugCNte6WdyC-Rxc6yfnuR=+6_qMbA@mail.gmail.com>
 <548A0125.6040708@linutronix.de>
 <CABH3fy8zCjsxARsqBf9JXOHBkzySdiqifA1KtjnGpJdBY2EikA@mail.gmail.com>
 <912A29987EAE174BA6CF187D7CDFA9CE26FA135A@DLEE08.ent.ti.com>
 <CABH3fy8S1Hb9LK=ZceWgJsNvLbq8pwu00Tcj_0vE4j6QzcO+kg@mail.gmail.com>
Message-ID: <20141216153048.GA16981@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 16, 2014 at 10:31:47AM +0200, Catalin Crenguta wrote:
> 
> It seems that because the ribbon cable has both the analog and digital
> signals, the analog signals are affected by the digital ones (hence
> the touchscreen was working OK when the display was disabled). Putting
> decoupling capacitors on X+, X-, Y+, Y- reduces the noise and the
> false events disappear.

IOW, the root cause is a design flaw in the BB-View 4.3 Cape?

Thanks,
Richard
