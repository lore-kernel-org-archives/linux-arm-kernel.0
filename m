From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 17 Dec 2012 16:29:51 +0100
Subject: [QUESTION] mmc: mmci: Howto merge patches
Message-ID: <CAPDyKFpXyVCzFWkyL3+92Zb9hoyKaEV4hpaUYO9O5o71nNmk8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell and Chris,

I would like to propose a change of how we handle mmci patches to be
merged. Instead of going through Russell's arm tree, I would like
Chris to handle the merge through his mmc tree.

The reason is simply that patches can have dependencies to the
protocol layer and in seems a bit unnecessary to wait for another
merge window to occur to handle these patches.
Moreover, if most of the mmci patches goes through Chris mmc tree, I
believe we would minimize the number of possible conflicts. Russell
will then only need to NACK patches to prevent them from being merged.

Do you think this could be and acceptable setup for both of you?

Kind regards
Ulf Hansson
