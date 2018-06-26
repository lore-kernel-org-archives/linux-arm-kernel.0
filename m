From: dianders@chromium.org (Doug Anderson)
Date: Tue, 26 Jun 2018 11:15:14 -0700
Subject: [PATCH v8 2/2] regulator: add QCOM RPMh regulator driver
In-Reply-To: <20180626150203.GG1779@sirena.org.uk>
References: <cover.1529712888.git.collinsd@codeaurora.org>
 <35c4ea70cdf5caba560fb6f40e866ee8bc456d93.1529712888.git.collinsd@codeaurora.org>
 <CAD=FV=XVEEPgjBXxR+-46RgxLOq63Xvq-jtruoaCxccmMoKUuA@mail.gmail.com>
 <20180626120733.GD1779@sirena.org.uk>
 <CAD=FV=X1E8Cz=L93G-zJwhM0R=N3YuBBhkvCnLvWuxMU9KJkTw@mail.gmail.com>
 <20180626150203.GG1779@sirena.org.uk>
Message-ID: <CAD=FV=WC_XWRk-6OELOFFWGnhRq1VeoiiveqXLSy+xqsVb22pA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 26, 2018 at 8:02 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Jun 26, 2018 at 08:00:29AM -0700, Doug Anderson wrote:
>> On Tue, Jun 26, 2018 at 5:07 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > Please do not submit new versions of already applied patches, please
>> > submit incremental updates to the existing code.  Modifying existing
>> > commits creates problems for other users building on top of those
>> > commits so it's best practice to only change pubished git commits if
>> > absolutely essential.
>
>> Sorry, wasn't suggesting making any changes to those two patches, just
>> was noting the dependency.  ...but, as you said, the two dependent
>> patches have already landed and I just didn't notice.  :(  Sorry for
>> the noise.
>
> Ah, so there's no revisions that need merging?  That's great.

Right.  So all that's left to do is decide if ${SUBJECT} patch is
ready to land and how to land it.  Andy has landed RPMh into his
for-next tree.  You can see it at
<https://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git/log/?h=for-next>.
I think he's still planning on re-shuffling his tree a bit.  When he
does this, do you need him to put the RPMh patches somewhere you can
merge into your tree?

Thanks!

-Doug
