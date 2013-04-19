From: peter.maydell@linaro.org (Peter Maydell)
Date: Fri, 19 Apr 2013 17:33:18 +0100
Subject: [RFC] arm64: Early printk support for virtio-mmio console devices.
In-Reply-To: <20130419162226.GB5383@localhost.cambridge.arm.com>
References: <CAAHg+HhtCorArCmx=ha0=64+SJZiizzrDUKSPLV=N+OzO8zAxQ@mail.gmail.com>
 <20130419090558.GA13283@mudshark.cambridge.arm.com>
 <CAAHg+HipCX2ma6brxj9Kgc3ew39b5e30grLwyun9CViif-5wZQ@mail.gmail.com>
 <20130419092752.GB13283@mudshark.cambridge.arm.com>
 <CAFEAcA8j124G=vaHObJ_w5wOhUiS3KYKbjMnigbnr6mgwFxZUg@mail.gmail.com>
 <CAAHg+Hg=t97SJ0JPZYgrZaL+zimo-wbezwaj1BQvHqE-vf4VDA@mail.gmail.com>
 <20130419093953.GD13283@mudshark.cambridge.arm.com>
 <CAFEAcA_WfYpyvq54rZqS8JZkmDF5JXB+CNHFH5CnrhKun52uzA@mail.gmail.com>
 <20130419161201.GA5383@localhost.cambridge.arm.com>
 <CAFEAcA-F18kR4JihdxaLTm3qb4n51tsygG1RW4djwJ0u9+FQqw@mail.gmail.com>
 <20130419162226.GB5383@localhost.cambridge.arm.com>
Message-ID: <CAFEAcA_vdXbtK=U2gauC=DsrB=_cSfcUTaNCiB0Ts4YOq_pXEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 April 2013 17:22, Catalin Marinas <catalin.marinas@arm.com> wrote:
> earlyprintk is used for debugging early problems, like DT parsing. You
> don't have to use it unless you are debugging something. Without
> earlyprintk you just get a normal console during boot, based on the DT
> description.

The command line lives in the DTB anyway so if you can't look
in the DTB you can't get at earlyprintk config either way.

-- PMM
