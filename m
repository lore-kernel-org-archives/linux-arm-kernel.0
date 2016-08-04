From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 4 Aug 2016 09:42:25 +0100
Subject: Can cores have different CPU features in a SMP system?
In-Reply-To: <CAP5Nno6c8VH3x2BfNnQO3uv=ktfHL=FGBG1=7ZNqwjcwBXsGgg@mail.gmail.com>
References: <CAP5Nno430Jt3Ax2jUPP6ELpVBF-pK0Akxsa8sZ55f8GL7LQt=g@mail.gmail.com>
 <CAP5Nno4CN18x_L-UQPm0Wp7hFSQAKtRobV94iBkcB9y4-UeRpg@mail.gmail.com>
 <b9577b33-0401-cf0f-bac2-f0315f520356@arm.com>
 <CAP5Nno6Taupawth4pghFt4aidQx=ib=3yswdV=QPZeY6c-6RmQ@mail.gmail.com>
 <c3706488-98db-9a71-22b1-0d56cfb3f2a7@arm.com>
 <0cfc0ca3-f056-c666-4a9b-4ebd8e0612d5@arm.com>
 <CAP5Nno6c8VH3x2BfNnQO3uv=ktfHL=FGBG1=7ZNqwjcwBXsGgg@mail.gmail.com>
Message-ID: <685c11c7-5d29-7993-1d92-20789cb6f683@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08/16 05:14, Jun Sun wrote:
> Maybe I'm missing something.  read_system_reg() seems to be reading
> the values initialized by cpu0.

and subsequently updated by other CPUs. See : update_cpu_ftr_reg()

Suzuki
