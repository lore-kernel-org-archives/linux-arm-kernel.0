From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 18 Aug 2018 02:52:11 +0200
Subject: [PATCH v2] gpio: brcmstb: allow 0 width GPIO banks
In-Reply-To: <1534549659-15883-1-git-send-email-justinpopo6@gmail.com>
References: <1534549659-15883-1-git-send-email-justinpopo6@gmail.com>
Message-ID: <20180818005211.GC26866@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 17, 2018 at 04:47:39PM -0700, justinpopo6 at gmail.com wrote:
> From: Justin Chen <justinpopo6@gmail.com>
> 
> Sometimes we have empty banks within the GPIO block. This commit allows
> proper handling of 0 width GPIO banks.

Hi Justin

This is coming from DT? Why do you put 0 width banks in DT in the
first place?

      Andrew
