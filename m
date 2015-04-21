From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 21 Apr 2015 11:24:54 -0700
Subject: [RFC PATCH v2 0/1] ARM: cpuidle: heterogeneous systems extension
In-Reply-To: <1429200617-9546-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1429200617-9546-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <CAMAWPa_fMhgFfL8krDxT9h42mydVogkaYQt1Me1qJTsKeH5dSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 16, 2015 at 9:10 AM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:

[...]

> This patch sets the maximum number of static CPUidle drivers allowed to
> two, since it is hard to foresee systems with more than two sets of CPUs
> having different idle states

It's not hard to forsee anymore:

   http://www.cnx-software.com/2015/04/21/mediatek-helio-x20-deca-core-processor/
   https://liliputing.com/2015/04/closer-look-at-mediateks-upcoming-10-core-helio-x20-processor.html

Kevin
