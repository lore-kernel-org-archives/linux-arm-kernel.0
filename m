From: robherring2@gmail.com (Rob Herring)
Date: Sun, 20 Jul 2014 21:15:06 -0500
Subject: [PATCH 1/2] PCI: spear: Fix Section mismatch compilation warning
 for probe()
In-Reply-To: <CAKohpokOJLKOwB_rKz0W-1T0nYX7-2_8nm3wQr6khR55x4gqrA@mail.gmail.com>
References: <76576b662613369d0c71db30ceed4ed5ae1343d2.1405857442.git.viresh.kumar@linaro.org>
 <20140720192649.GA30124@quad.lixom.net>
 <CAKohpokOJLKOwB_rKz0W-1T0nYX7-2_8nm3wQr6khR55x4gqrA@mail.gmail.com>
Message-ID: <CAL_Jsq+dSoYp83wnXXHnfQ__GkQvoNcijmktvwqvcpazsQGioQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 20, 2014 at 7:12 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 21 July 2014 00:56, Olof Johansson <olof@lixom.net> wrote:
>> Please use 12 significant digits, since 7 might not be sufficient later
>> on in time. I've fixed it up here.
>
> I surely didn't knew this and haven't seen other maintainers do this
> as well.. And thought, whatever "git log --online" gives would be
> enough.

The Fixes tag is new and the format is documented in SubmittingPatches
IIRC. I believe it is also supposed to be quotes rather than
parentheses around the commit message if we want to be really picky.

Rob
