From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 22 Sep 2015 09:21:10 +0200
Subject: [PATCH v6 07/22] regulator: core: Remove regulator_list
In-Reply-To: <20150921193803.GB30445@sirena.org.uk>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
 <1442844182-27787-8-git-send-email-tomeu.vizoso@collabora.com>
 <20150921193803.GB30445@sirena.org.uk>
Message-ID: <CAAObsKBuJMnoXY5gmshF3JQvD5j18UhxC0yuoZqR2x+LGmRGxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 September 2015 at 21:38, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Sep 21, 2015 at 04:02:47PM +0200, Tomeu Vizoso wrote:
>> As we are already registering a device with regulator_class for each
>> regulator device, regulator_list is redundant and can be replaced with
>> calls to class_find_device() and class_for_each_device().
>
> I've done an initial review of this and will push it to git so it can go
> into the various test systems.  It's on a branch by itself so if there's
> issues it's easy to back out, either from testing or from review from me
> or others.  If we get to the point of merging the whole series then I'll
> tag the code for cross merging.
>
> Thanks a lot for working on this, this is something I'd started looking
> at myself and it's a lot easier to just review code from someone else!

Thanks for your patience, will keep an eye on possible regressions.

Regards,

Tomeu
