From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 13 Mar 2012 12:18:03 -0600
Subject: [PATCH v3 2/2] regulator: add device tree support for max8997
In-Reply-To: <CAJuYYwRAXyU7d7qhGUX-=qWUJ0M1KB3XCGPOnUxToP=0XOhzqg@mail.gmail.com>
References: <1330000688-11226-1-git-send-email-thomas.abraham@linaro.org>
 <1330000688-11226-3-git-send-email-thomas.abraham@linaro.org>
 <20120313034306.16CF73E07E4@localhost>
 <CAJuYYwRAXyU7d7qhGUX-=qWUJ0M1KB3XCGPOnUxToP=0XOhzqg@mail.gmail.com>
Message-ID: <20120313181803.B45073E053B@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Mar 2012 12:14:42 +0530, Thomas Abraham <thomas.abraham@linaro.org> wrote:
> On 13 March 2012 09:13, Grant Likely <grant.likely@secretlab.ca> wrote:
> > On Thu, 23 Feb 2012 18:08:08 +0530, Thomas Abraham <thomas.abraham@linaro.org> wrote:
> > Otherwise, the patch looks pretty good. ??(although seeing the decode function
> > has got me thinking that we need a much better way of decoding the dt data).
> 
> The parsing function looks huge since there is lot of data to pick up
> from the dt node.

Oh, I understand that you have to do it this way; I just think the core code
should make it a lot easier.  :-)

g.
