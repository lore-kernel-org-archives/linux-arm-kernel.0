From: omycle@gmail.com (Li Haifeng)
Date: Mon, 2 Jul 2012 15:51:05 +0800
Subject: Question about memory protected between user-space and kernel-space
Message-ID: <CAFNq8R640GRmLvJ_M2bUr8+JG1DaxvDAoS9=xehfUu=46PWsRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In general, virtual address above 3GB could be only accessible by
kernel-domain itself, and be blocked by user-domain.

Could you please give a brief introduction how to implement it?

In my scene, the protected above rely to the DAC register (CP15 C3
register). But in kernel code, the domain value in PTE of user mapping
and kernel mapping are the same.
