From: joe@perches.com (Joe Perches)
Date: Tue, 27 Jan 2015 07:42:34 -0800
Subject: [PATCH 11/18] spi/xilinx: Remove rx_fn and tx_fn pointer
In-Reply-To: <CAPybu_3gF1BXhq4j5Z3DfM8_PxuK72Pshm6_5qVKH-ZyYTpgig@mail.gmail.com>
References: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
 <1422029330-10971-12-git-send-email-ricardo.ribalda@gmail.com>
 <20150127000903.GM21293@sirena.org.uk>
 <CAPybu_3gF1BXhq4j5Z3DfM8_PxuK72Pshm6_5qVKH-ZyYTpgig@mail.gmail.com>
Message-ID: <1422373354.18650.8.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-01-27 at 11:00 +0100, Ricardo Ribalda Delgado wrote:
> >> +     xspi->rx_ptr += xspi->bits_per_word/8;
> > Also there's
> > a coding style thing - spaces around the / please.
[]
> I am also cc: the maintainers of checkpatch, because for whatever
> reason, this was not found by the script

Because it's personal preference.

checkpatch would note if a space was used
inconsistently (before but not after the /,
or the other way 'round)
