From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Tue, 28 Mar 2017 12:18:04 +0200
Subject: [PATCH v2] net: moxa: fix TX overrun memory leak
In-Reply-To: <20170327.205026.1935467634311224337.davem@davemloft.net>
References: <1490617879-14014-1-git-send-email-jonas.jensen@gmail.com>
 <20170327.205026.1935467634311224337.davem@davemloft.net>
Message-ID: <CACmBeS1E4TrUzq5-L_y0=dFY6=HdGAJSbsaBW2mfmvxctWvX2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 March 2017 at 05:50, David Miller <davem@davemloft.net> wrote:
> Doing the wakeup unconditionally is very wasteful, you just need to do it
> when enough space has been made available.

Thanks, please see v3.


   Jonas
