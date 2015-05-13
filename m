From: broonie@kernel.org (Mark Brown)
Date: Wed, 13 May 2015 12:03:57 +0100
Subject: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <20150513085528.GA6994@linux>
References: <cover.1430394884.git.viresh.kumar@linaro.org>
 <d225e73f183e01fa0b71e4b9248b6a19a3f7d697.1430394884.git.viresh.kumar@linaro.org>
 <20150512214224.16410.15922@quantum> <20150513085528.GA6994@linux>
Message-ID: <20150513110357.GD3066@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 02:25:28PM +0530, Viresh Kumar wrote:
> On 12-05-15, 14:42, Michael Turquette wrote:
> > Quoting Viresh Kumar (2015-04-30 05:07:59)
> 
> > Why should this new binding exist?

> The answer to this particular query is perhaps simple, i.e. we have
> unsolved problems that we wanted to solve in a generic way.

> But probably the bigger question is "Should we really put the OPPs
> (new or old bindings) in DT".

And also is trying to do this in a completely generic manner the right
way of going about things - do we really understand the problem area
well enough to create a completely generic solution for all cases,
bearing in mind that once things go into a DT binding they become an ABI?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150513/2aa55f2b/attachment.sig>
