From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 11 Sep 2012 17:31:56 +0200
Subject: pinctrl: mvebu: minor fixes
In-Reply-To: <1347373204-17883-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1347266386-16229-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347373204-17883-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CABJ1b_Se0w2W+LHhknUqYOBQurCdmYbWnkxX8hJhOFkXAo30xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/11/12, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:
> Here are two minor fixes for the pinctrl-mvebu.c driver. The v3 of the
> driver still doesn't work for me on Armada 370/XP. I'm investigating,
> but I'm not sure to understand some of the changes you've made in the
> v3.

Thomas,

thanks for this one! After reviewing the offending code, I realized
that it must
be an old(er) version of the pinctrl core. I ll dig out the correct
version and report
on list accordingly.

Sebastian
