From: jassisinghbrar@gmail.com (jassi brar)
Date: Thu, 28 Jan 2010 16:27:54 +0900
Subject: Problems with device compilation by subsystem config
In-Reply-To: <20100128070518.GS10014@trinity.fluff.org>
References: <20100128070518.GS10014@trinity.fluff.org>
Message-ID: <1b68c6791001272327y79b6cc98g56ddcdf015766c36@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2010 at 4:05 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> To fix thsi I propose changing the SPI and Audio support to have their
> own 'config S3C_DEV_xxx' entries which are selected by the boards that
> use them (this removes the need for #ifdef in the board file) and these
> entries should not be dependant on the subsytem defines.
I see the point.
I am preparing patches for new machine selectable config options for SPI and
AUDIO (even though I am not the original author of dev-audio.c but Mark
can always NAK the patch if he disagrees)
