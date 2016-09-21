From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 21 Sep 2016 22:42:42 +0200
Subject: [GIT PULL] Qualcomm EBI2 bindings and bus driver
In-Reply-To: <CACRpkdZdoK4+YRrZC=Kd8TFzJXOQxh=Gi0BWLp4PzV6H5_wEtg@mail.gmail.com>
References: <CACRpkdYvowN2htUuN46JNVdfaKNw3AEbBfzAeScHQcLU5o3ZUg@mail.gmail.com>
 <20160919223616.GD5431@hector.attlocal.net>
 <CACRpkdZdoK4+YRrZC=Kd8TFzJXOQxh=Gi0BWLp4PzV6H5_wEtg@mail.gmail.com>
Message-ID: <75785466.JAjuGRDEOe@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, September 20, 2016 11:50:14 PM CEST Linus Walleij wrote:
> On Tue, Sep 20, 2016 at 12:36 AM, Andy Gross <andy.gross@linaro.org> wrote:
> > On Tue, Sep 20, 2016 at 12:12:33AM +0200, Arnd Bergmann wrote:
> >> On Thursday, September 8, 2016 3:34:42 PM CEST Linus Walleij wrote:
> >> > please pull this new EBI2 bus driver and its bindings into an
> >> > apropriate branch in the ARM SoC tree. The binding now has
> >> > Rob Herrings ACK and we have hopefully finally figured out how
> >> > this should be done.
> >> >
> >>
> >> I just noticed that you sent the pull request directly to arm at kernel.org
> >> rather than the Qualcomm maintainers (which are only on Cc).
> >>
> >> Usually, I'd expect to see this forwarded from Andy, is there a
> >> reason to do it differently here? If so, can I have an Ack
> >> from him?
> >
> > When I looked at this last, I thought there were comments.  Sorry I missed it.
> > If you want to pick it up Arnd, please do, otherwise I can send it along in the
> > next pull request.
> >
> > Acked-by: Andy Gross <andy.gross@linaro.org>
> 
> Thanks, I hope Arnd can pull this as-is.
> 

Pulled into next/drivers, with Andy's Ack added to the merge commit, thanks!

	Arnd
