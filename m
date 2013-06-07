From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 7 Jun 2013 16:26:36 +0530
Subject: [GIT PULL] CPUFreq: ARM Updates for v3.11
Message-ID: <CAKohpokdrw1KZuCx6Y5E1JyK-Yq0T1fh0qP+bEaqgZjoK8JEEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

The following changes since commit d683b96b072dc4680fc74964eca77e6a23d1fa6e:

  Linux 3.10-rc4 (2013-06-02 17:11:17 +0900)

are available in the git repository at:

  git://git.linaro.org/people/vireshk/linux.git cpufreq-next

for you to fetch changes up to f13ad5d9829c060fffe5bf45b05cc3c689a2e719:

  cpufreq: kirkwood: Select CPU_FREQ_TABLE option (2013-06-07 16:21:13 +0530)

----------------------------------------------------------------
Arnd Bergmann (2):
      cpufreq: SPEAr needs cpufreq table
      cpufreq: bit.LITTLE needs cpufreq table

Ezequiel Garcia (1):
      cpufreq: kirkwood: Select CPU_FREQ_TABLE option

 drivers/cpufreq/Kconfig.arm | 3 +++
 1 file changed, 3 insertions(+)

--
Viresh
