From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 13 May 2015 21:17:46 +0530
Subject: [PATCH 1/3 v6] dt/bindings: Add binding for the BCM2835 mailbox
 driver
In-Reply-To: <20150513075705.GB3394@x1>
References: <1430857666-18877-1-git-send-email-eric@anholt.net>
 <CABb+yY3fDP_U8dz7TEJ+N6gKwhkQKdsfXDq209nQUCWu-zZYgg@mail.gmail.com>
 <20150513075705.GB3394@x1>
Message-ID: <CABb+yY34qTF7jMw_0uHiOvaQaG5ubNVWPLjjrLdNgo7eoSqYXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 1:27 PM, Lee Jones <lee@kernel.org> wrote:
> On Tue, 12 May 2015, Jassi Brar wrote:
>> On Wed, May 6, 2015 at 1:57 AM, Eric Anholt <eric@anholt.net> wrote:
>> > From: Lubomir Rintel <lkundrak@v3.sk>
>> >
>> > This patch was split out of Lubomir's original mailbox patch by Eric
>> > Anholt, and the required properties documentation and examples have
>> > been filled out more completely and updated for the driver being
>> > changed to expose a single channel.
>> >
>> > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>> > Signed-off-by: Craig McGeachie <slapdau@yahoo.com.au>
>> > Signed-off-by: Eric Anholt <eric@anholt.net>
>> > Acked-by: Lee Jones <lee.jones@linaro.org>
>> > Acked-by: Stephen Warren <swarren@wwwdotorg.org>
>> > ---
>> Thanks to the reviewers. Applied all 3 patches.
>
> Jassi, can you remove patch 3/3 from your tree please?  Changes to
> DTS(I) files should go in via ARM-SoC.  If SS Maintainers took DT
> changes, there would be carnage.
>
> I'm going to apply it now.
>
Done. Thanks for the heads up.
