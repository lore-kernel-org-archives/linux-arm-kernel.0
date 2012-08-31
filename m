From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Fri, 31 Aug 2012 11:04:44 +0100
Subject: [PATCH] hvc_dcc : add support to armv4 and armv5 core
In-Reply-To: <1346404916-27616-1-git-send-email-castet.matthieu@free.fr>
References: <1346404916-27616-1-git-send-email-castet.matthieu@free.fr>
Message-ID: <20120831110444.25d9b9fe@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 31 Aug 2012 11:21:56 +0200
Matthieu CASTET <castet.matthieu@free.fr> wrote:

> Signed-off-by: Matthieu Castet <matthieu.castet@parrot.com>
> ---
>  drivers/tty/hvc/hvc_dcc.c |   34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)

This is a step in the wrong direction. This should all be runtime handled

NAK.
