From: mjg59@srcf.ucam.org (Matthew Garrett)
Date: Thu, 28 Nov 2013 18:48:52 +0000
Subject: ACPI
In-Reply-To: <alpine.DEB.2.02.1311281816350.3198@kaball.uk.xensource.com>
References: <CACxGe6uHuWPh7d9NaVuPRBWq0Fh1BmDV190KEN4C4uaq4KjS8g@mail.gmail.com>
 <CACRpkdaCXJzWXoesjD3Jqpm4XMHLQp3SsHcsDG3veUS+xarqHQ@mail.gmail.com>
 <CACxGe6vUKzow7QpeX2mU7CiZQzY8aZ+p0jd8Vk0+dqz0B=D0Ew@mail.gmail.com>
 <20131125154110.GB3243@srcf.ucam.org>
 <CACRpkdY+6dzs8MpKKtW-3kzsLkZjsit9SeN20k_33TAtVf3NEA@mail.gmail.com>
 <CACxGe6t_9hUXL_1PHRU=2DYOYfCqZykd7gYRCshZn0XsVoCdRw@mail.gmail.com>
 <20131126183344.GA16074@srcf.ucam.org>
 <CAHCPf3t-dKc-xwjLCEWrY6kmi4_dLHp4iMgOwdEJ43UGK9=khQ@mail.gmail.com>
 <20131126233224.GA21189@srcf.ucam.org>
 <alpine.DEB.2.02.1311281816350.3198@kaball.uk.xensource.com>
Message-ID: <20131128184851.GA2365@srcf.ucam.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 28, 2013 at 06:26:11PM +0000, Stefano Stabellini wrote:

> In that case, I think that we should use the one we know has better
> support in the kernel, that at the moment is device tree but in the
> future might change.

We can't just flip this - systems that shipped with valid DT but broken 
ACPI would stop working. 

-- 
Matthew Garrett | mjg59 at srcf.ucam.org
