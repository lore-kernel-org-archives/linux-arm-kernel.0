From: broonie@kernel.org (Mark Brown)
Date: Mon, 24 Oct 2016 19:19:37 +0100
Subject: [PATCH/RFT v2 09/17] regulator: fixed: Add over current event
In-Reply-To: <CAKXjFTNZhWTZSXtLZo8EieBtAPn_J-MM+-g8yCRJiV6UBspB9Q@mail.gmail.com>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
 <20161024164634.4330-10-ahaslam@baylibre.com>
 <20161024175320.GO17252@sirena.org.uk>
 <CAKXjFTNZhWTZSXtLZo8EieBtAPn_J-MM+-g8yCRJiV6UBspB9Q@mail.gmail.com>
Message-ID: <20161024181937.GP17252@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2016 at 08:11:40PM +0200, Axel Haslam wrote:
> On Mon, Oct 24, 2016 at 7:53 PM, Mark Brown <broonie@kernel.org> wrote:

> > does it make sense to report this as a mode, we don't report other error
> > conditions as modes but instead use REGULATOR_STATUS_ with the
> > get_status() operation?

> I used mode, because when the regulator toggles the overcurrent
> line, it means that it has entered a current limited mode, at least the
> regulator im looking at. ill change to STATUS

That's not what regulator modes are - please look at the documentation
for the defines here.  They're about the quality of regulation.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161024/e50d7f07/attachment.sig>
