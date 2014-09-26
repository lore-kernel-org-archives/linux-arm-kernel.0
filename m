From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 26 Sep 2014 07:23:21 -0700
Subject: [GIT PULL] PM / AVS changes for v3.18 - v2
In-Reply-To: <20140926081534.GA27755@sirena.org.uk> (Mark Brown's message of
 "Fri, 26 Sep 2014 09:15:34 +0100")
References: <7ha95nikqh.fsf@linaro.org> <20140926081534.GA27755@sirena.org.uk>
Message-ID: <7hmw9m795y.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown <broonie@kernel.org> writes:

> On Thu, Sep 25, 2014 at 12:05:42PM -0700, Kevin Hilman wrote:
>
>> The first pull request was missing a dependency on a feature that went
>> in through Mark Brown's regulator tree, so it wouldn't actually compile
>> properly by itself.  This version pulls in that topic branch from Marks
>> tree (topic/voltage-ev branch, already part of -next), and now compiles fine.
>
> Please in future don't pull anything in from my tree without a signed
> tag (speak to me if there isn't one).

Sorry about that.

Had there been more than one patch in this topic branch, or it wasn't
based directly on an -rc tag, I would've waited for confirmation about
it being stable, but since it was a single patch, based directly on an
-rc tag, I assumed it was stable.

In the future, I'll be sure to request a signed tag.

Kevin
