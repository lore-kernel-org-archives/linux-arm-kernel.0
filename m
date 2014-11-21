From: bjorn@kryo.se (Bjorn Andersson)
Date: Fri, 21 Nov 2014 10:25:48 -0800
Subject: [PATCH 3/3] regulator: rpm: add support for RPM-controller SMB208
In-Reply-To: <20141121181332.GY3815@sirena.org.uk>
References: <1416512485-7292-1-git-send-email-joshc@codeaurora.org>
 <1416512485-7292-4-git-send-email-joshc@codeaurora.org>
 <20141121181332.GY3815@sirena.org.uk>
Message-ID: <CAJAp7OhY2pz+ppjbYRrjZ2E3Bn9NM54dfs1=xoqxd5tG5e3WaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21, 2014 at 10:13 AM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Nov 20, 2014 at 01:41:25PM -0600, Josh Cartwright wrote:
>> The IPQ8064 reference boards make use of SMB208 regulators which are
>> controlled by RPM.  Implement support for these regulators in the RPM
>> regulator driver.
>
> I'm missing both patches 1-3 and the cover letter, what's the story
> with the series - are there interdependencies?

Hi Mark,

There are no new dependencies introduced here, patch 1 and 2 are DT
and mfd additions. So you can apply this patch independently in your
tree.

Acked-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Regards,
Bjorn
