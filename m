From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 26 Sep 2014 08:42:38 -0700
Subject: [GIT PULL] PM / AVS changes for v3.18 - v2
In-Reply-To: <7hmw9m795y.fsf@deeprootsystems.com>
References: <7ha95nikqh.fsf@linaro.org> <20140926081534.GA27755@sirena.org.uk>
 <7hmw9m795y.fsf@deeprootsystems.com>
Message-ID: <CAMAWPa9E-HY8tbMU3y8EHv0XhCHynTopSMupDHF4R2wBvLEOSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 26, 2014 at 7:23 AM, Kevin Hilman <khilman@kernel.org> wrote:
> Mark Brown <broonie@kernel.org> writes:
>
>> On Thu, Sep 25, 2014 at 12:05:42PM -0700, Kevin Hilman wrote:
>>
>>> The first pull request was missing a dependency on a feature that went
>>> in through Mark Brown's regulator tree, so it wouldn't actually compile
>>> properly by itself.  This version pulls in that topic branch from Marks
>>> tree (topic/voltage-ev branch, already part of -next), and now compiles fine.
>>
>> Please in future don't pull anything in from my tree without a signed
>> tag (speak to me if there isn't one).
>
> Sorry about that.
>
> Had there been more than one patch in this topic branch, or it wasn't
> based directly on an -rc tag, I would've waited for confirmation about
> it being stable, but since it was a single patch, based directly on an
> -rc tag, I assumed it was stable.
>
> In the future, I'll be sure to request a signed tag.

Hmm, turns out there actually was a signed tag[1] (I thought I
remembered you saying it was stable), but I still made the mistake of
pulling the branch and not the tag.

Kevin

[1] https://lkml.org/lkml/2014/8/29/182
