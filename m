From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 3 Jun 2016 14:05:12 +0100
Subject: [PATCH v4 10/18] ASoC: sti: Update DT example to match the
 driver code
In-Reply-To: <20160527171403.GN16172@sirena.org.uk>
References: <1464192412-16386-1-git-send-email-peter.griffin@linaro.org>
 <1464192412-16386-12-git-send-email-peter.griffin@linaro.org>
 <20160527171403.GN16172@sirena.org.uk>
Message-ID: <20160603130512.GF9912@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Fri, 27 May 2016, Mark Brown wrote:

> On Wed, May 25, 2016 at 05:06:44PM +0100, Peter Griffin wrote:
> > uniperiph-id, version and mode are ST specific bindings and
> > need the 'st,' prefix. Update the examples, as otherwise copying
> > them yields a runtime error parsing the DT node.
> 
> You've not copied me on the rest of the series so I've no idea what's
> going on with dependencies.  When sending a patch series it is important
> to ensure that all the various maintainers understand what the
> relationship between the patches as the expecation is that there will be
> interdependencies.  Either copy everyone on the whole series or at least
> copy them on the cover letter and explain what's going on.  If there are
> no strong interdependencies then it's generally simplest to just send
> the patches separately to avoid any possible confusion.

Ok will bare this in mind for v5 series.

Regards,

Peter.
